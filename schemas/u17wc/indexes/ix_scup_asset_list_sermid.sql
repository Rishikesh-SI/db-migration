-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: u17wc
-- Object: ix_scup_asset_list_sermid
-- Type: INDEX

-- Name: ix_scup_asset_list_sermid; Type: INDEX; Schema: u17wc; Owner: -
--

CREATE INDEX ix_scup_asset_list_sermid ON u17wc.u17wc_asset_list USING btree (secondary_entity_role_map_id);


--
