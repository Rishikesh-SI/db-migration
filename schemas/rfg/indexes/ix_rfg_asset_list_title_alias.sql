-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: rfg
-- Object: ix_rfg_asset_list_title_alias
-- Type: INDEX

-- Name: ix_rfg_asset_list_title_alias; Type: INDEX; Schema: rfg; Owner: -
--

CREATE INDEX ix_rfg_asset_list_title_alias ON rfg.rfg_asset_list USING btree (title_alias);


--
