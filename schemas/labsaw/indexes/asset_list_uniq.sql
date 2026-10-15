-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsaw
-- Object: asset_list_uniq
-- Type: INDEX

-- Name: asset_list_uniq; Type: INDEX; Schema: labsaw; Owner: -
--

CREATE INDEX asset_list_uniq ON labsaw.labsaw_asset_list USING btree (asset_id, asset_type_id, title_alias);


--
