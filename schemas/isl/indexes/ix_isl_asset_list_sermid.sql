-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: ix_isl_asset_list_sermid
-- Type: INDEX

-- Name: ix_isl_asset_list_sermid; Type: INDEX; Schema: isl; Owner: -
--

CREATE INDEX ix_isl_asset_list_sermid ON isl.isl_asset_list USING btree (secondary_entity_role_map_id);


--
