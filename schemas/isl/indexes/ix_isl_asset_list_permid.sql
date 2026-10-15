-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: ix_isl_asset_list_permid
-- Type: INDEX

-- Name: ix_isl_asset_list_permid; Type: INDEX; Schema: isl; Owner: -
--

CREATE INDEX ix_isl_asset_list_permid ON isl.isl_asset_list USING btree (primary_entity_role_map_id);


--
