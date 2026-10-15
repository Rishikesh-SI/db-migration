-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labyho
-- Object: tsv_idx
-- Type: INDEX

-- Name: tsv_idx; Type: INDEX; Schema: labyho; Owner: -
--

CREATE INDEX tsv_idx ON labyho.labyho_asset_list USING gin (tvs);


--
