-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmsg
-- Object: ix_ttmum_asset_list_title_alias
-- Type: INDEX

-- Name: ix_ttmum_asset_list_title_alias; Type: INDEX; Schema: labmsg; Owner: -
--

CREATE INDEX ix_ttmum_asset_list_title_alias ON labmsg.labmsg_asset_list USING btree (title_alias);


--
