-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: ix_zeven_asset_list_title_alias
-- Type: INDEX

-- Name: ix_zeven_asset_list_title_alias; Type: INDEX; Schema: zeven; Owner: -
--

CREATE INDEX ix_zeven_asset_list_title_alias ON zeven.zeven_asset_list USING btree (title_alias);


--
