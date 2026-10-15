-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: fanxp_lsg
-- Object: lablsg_asset_list_title_alias_idx
-- Type: INDEX

-- Name: lablsg_asset_list_title_alias_idx; Type: INDEX; Schema: fanxp_lsg; Owner: -
--

CREATE INDEX lablsg_asset_list_title_alias_idx ON fanxp_lsg.lablsg_asset_list USING btree (title_alias);


--
