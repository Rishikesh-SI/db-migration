-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: utt
-- Object: ix_upp_asset_list_sermid
-- Type: INDEX

-- Name: ix_upp_asset_list_sermid; Type: INDEX; Schema: utt; Owner: -
--

CREATE INDEX ix_upp_asset_list_sermid ON utt.utt_asset_list USING btree (secondary_entity_role_map_id);


--
