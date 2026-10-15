-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: fanxp_lsg
-- Object: lablsg_asset_draft_asset_type_id_idx
-- Type: INDEX

-- Name: lablsg_asset_draft_asset_type_id_idx; Type: INDEX; Schema: fanxp_lsg; Owner: -
--

CREATE INDEX lablsg_asset_draft_asset_type_id_idx ON fanxp_lsg.lablsg_asset_draft USING btree (asset_type_id);


--
