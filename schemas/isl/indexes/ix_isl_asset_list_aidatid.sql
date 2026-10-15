-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: ix_isl_asset_list_aidatid
-- Type: INDEX

-- Name: ix_isl_asset_list_aidatid; Type: INDEX; Schema: isl; Owner: -
--

CREATE INDEX ix_isl_asset_list_aidatid ON isl.isl_asset_list USING btree (asset_id, asset_type_id);


--
