-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labhsl
-- Object: ix_hsl_asset_list_permid
-- Type: INDEX

-- Name: ix_hsl_asset_list_permid; Type: INDEX; Schema: labhsl; Owner: -
--

CREATE INDEX ix_hsl_asset_list_permid ON labhsl.labhsl_asset_list USING btree (primary_entity_role_map_id);


--
