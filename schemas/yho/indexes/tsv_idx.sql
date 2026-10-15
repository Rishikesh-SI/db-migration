-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: tsv_idx
-- Type: INDEX

-- Name: tsv_idx; Type: INDEX; Schema: yho; Owner: -
--

CREATE INDEX tsv_idx ON yho.yho_asset_list USING gin (tvs);


--
