-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: hsl
-- Object: ix_hsl_asset_list_sermid
-- Type: INDEX

-- Name: ix_hsl_asset_list_sermid; Type: INDEX; Schema: hsl; Owner: -
--

CREATE INDEX ix_hsl_asset_list_sermid ON hsl.hsl_asset_list USING btree (secondary_entity_role_map_id);


--
