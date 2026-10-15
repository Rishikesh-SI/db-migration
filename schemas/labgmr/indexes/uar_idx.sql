-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgmr
-- Object: uar_idx
-- Type: INDEX

-- Name: uar_idx; Type: INDEX; Schema: labgmr; Owner: -
--

CREATE INDEX uar_idx ON labgmr.labgmr_user_asset_reaction USING btree (asset_id, asset_type_id, user_id, parent_comment_id NULLS FIRST);


--
