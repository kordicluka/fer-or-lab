"use client";

import { useState, useEffect } from "react";
import axios from "axios";
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table";
import { Input } from "@/components/ui/input";
import { Button } from "@/components/ui/button";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";
import { ChevronDown, Download } from "lucide-react";

type Pice = {
  id: number;
  naziv: string;
  vrsta: string;
  proizvodac: string;
  postotak_alkohola: number;
  cijena: number;
  volumen: number;
};

export default function DataTable() {
  const [data, setData] = useState<Pice[]>([]);
  const [filteredData, setFilteredData] = useState<Pice[]>([]);
  const [filter, setFilter] = useState("");
  const [filterColumn, setFilterColumn] = useState<keyof Pice | "all">("all");

  useEffect(() => {
    const fetchData = async () => {
      const result = await axios("/api/pica");
      setData(result.data);
      setFilteredData(result.data);
    };
    fetchData();
  }, []);

  useEffect(() => {
    const lowercasedFilter = filter.toLowerCase();
    const filtered = data.filter((item) => {
      if (filterColumn === "all") {
        return Object.values(item).some((val) =>
          val.toString().toLowerCase().includes(lowercasedFilter)
        );
      } else {
        return item[filterColumn]
          .toString()
          .toLowerCase()
          .includes(lowercasedFilter);
      }
    });
    setFilteredData(filtered);
  }, [filter, filterColumn, data]);

  const downloadCSV = () => {
    const headers = Object.keys(data[0] || {}).join(",");
    const csv = [
      headers,
      ...filteredData.map((row) => Object.values(row).join(",")),
    ].join("\n");

    const blob = new Blob([csv], { type: "text/csv;charset=utf-8;" });
    const link = document.createElement("a");
    if (link.download !== undefined) {
      const url = URL.createObjectURL(blob);
      link.setAttribute("href", url);
      link.setAttribute("download", "filtered_pica.csv");
      link.style.visibility = "hidden";
      document.body.appendChild(link);
      link.click();
      document.body.removeChild(link);
    }
  };

  const downloadJSON = () => {
    const jsonString = JSON.stringify(filteredData, null, 2);
    const blob = new Blob([jsonString], { type: "application/json" });
    const link = document.createElement("a");
    if (link.download !== undefined) {
      const url = URL.createObjectURL(blob);
      link.setAttribute("href", url);
      link.setAttribute("download", "filtered_pica.json");
      link.style.visibility = "hidden";
      document.body.appendChild(link);
      link.click();
      document.body.removeChild(link);
    }
  };

  return (
    <div className="container mx-auto px-4 py-8">
      <h1 className="text-3xl font-bold mb-6">
        Tablični prikaz podataka o pićima
      </h1>

      <div className="flex items-center space-x-4 mb-4">
        <Input
          placeholder="Pretraži..."
          value={filter}
          onChange={(e) => setFilter(e.target.value)}
          className="max-w-sm"
        />
        <DropdownMenu>
          <DropdownMenuTrigger asChild>
            <Button variant="outline">
              Filter po:{" "}
              {filterColumn === "all" ? "Svim stupcima" : filterColumn}
              <ChevronDown className="ml-2 h-4 w-4" />
            </Button>
          </DropdownMenuTrigger>
          <DropdownMenuContent>
            <DropdownMenuItem onSelect={() => setFilterColumn("all")}>
              Svim stupcima
            </DropdownMenuItem>
            {(Object.keys(data[0] || {}) as Array<keyof Pice>).map((key) => (
              <DropdownMenuItem key={key} onSelect={() => setFilterColumn(key)}>
                {key}
              </DropdownMenuItem>
            ))}
          </DropdownMenuContent>
        </DropdownMenu>
      </div>

      <div className="mb-4 space-x-2">
        <Button onClick={downloadCSV} variant="outline">
          <Download className="mr-2 h-4 w-4" /> Preuzmi CSV
        </Button>
        <Button onClick={downloadJSON} variant="outline">
          <Download className="mr-2 h-4 w-4" /> Preuzmi JSON
        </Button>
      </div>

      <div className="rounded-md border">
        <Table>
          <TableHeader>
            <TableRow>
              {(Object.keys(data[0] || {}) as Array<keyof Pice>).map((key) => (
                <TableHead key={key}>{key}</TableHead>
              ))}
            </TableRow>
          </TableHeader>
          <TableBody>
            {filteredData.map((row, index) => (
              <TableRow key={index}>
                {(Object.keys(row) as Array<keyof Pice>).map((key) => (
                  <TableCell key={key}>{row[key].toString()}</TableCell>
                ))}
              </TableRow>
            ))}
          </TableBody>
        </Table>
      </div>
    </div>
  );
}
