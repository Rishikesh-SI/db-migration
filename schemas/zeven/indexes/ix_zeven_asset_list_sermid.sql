-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: ix_zeven_asset_list_sermid
-- Type: INDEX

-- Name: ix_zeven_asset_list_sermid; Type: INDEX; Schema: zeven; Owner: -
--

CREATE INDEX ix_zeven_asset_list_sermid ON zeven.zeven_asset_list USING btree (secondary_entity_role_map_id);


--
