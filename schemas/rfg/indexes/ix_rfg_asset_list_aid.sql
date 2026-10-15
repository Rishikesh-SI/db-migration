-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: rfg
-- Object: ix_rfg_asset_list_aid
-- Type: INDEX

-- Name: ix_rfg_asset_list_aid; Type: INDEX; Schema: rfg; Owner: -
--

CREATE INDEX ix_rfg_asset_list_aid ON rfg.rfg_asset_list USING btree (asset_id);


--
