-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl
-- Object: idx_asset_list_tagent_array
-- Type: INDEX

-- Name: idx_asset_list_tagent_array; Type: INDEX; Schema: labpkl; Owner: -
--

CREATE INDEX idx_asset_list_tagent_array ON labpkl.labpkl_asset_list USING gin (tagged_entity public.gin__int_ops);


--
