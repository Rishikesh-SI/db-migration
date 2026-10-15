-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labets
-- Object: ix_ttmum_asset_list_aid
-- Type: INDEX

-- Name: ix_ttmum_asset_list_aid; Type: INDEX; Schema: labets; Owner: -
--

CREATE INDEX ix_ttmum_asset_list_aid ON labets.labets_asset_list USING btree (asset_id);


--
