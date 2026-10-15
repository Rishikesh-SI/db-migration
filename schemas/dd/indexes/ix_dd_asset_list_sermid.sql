-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd
-- Object: ix_dd_asset_list_sermid
-- Type: INDEX

-- Name: ix_dd_asset_list_sermid; Type: INDEX; Schema: dd; Owner: -
--

CREATE INDEX ix_dd_asset_list_sermid ON dd.dd_asset_list USING btree (secondary_entity_role_map_id);


--
