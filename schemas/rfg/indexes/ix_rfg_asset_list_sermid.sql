-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: rfg
-- Object: ix_rfg_asset_list_sermid
-- Type: INDEX

-- Name: ix_rfg_asset_list_sermid; Type: INDEX; Schema: rfg; Owner: -
--

CREATE INDEX ix_rfg_asset_list_sermid ON rfg.rfg_asset_list USING btree (secondary_entity_role_map_id);


--
