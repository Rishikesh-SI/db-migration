-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: fanxp_lsg
-- Object: lablsg_asset_list_lower_idx
-- Type: INDEX

-- Name: lablsg_asset_list_lower_idx; Type: INDEX; Schema: fanxp_lsg; Owner: -
--

CREATE INDEX lablsg_asset_list_lower_idx ON fanxp_lsg.lablsg_asset_list USING btree (lower((title_alias)::text));


--
