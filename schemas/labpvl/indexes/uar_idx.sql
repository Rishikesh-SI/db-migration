-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpvl
-- Object: uar_idx
-- Type: INDEX

-- Name: uar_idx; Type: INDEX; Schema: labpvl; Owner: -
--

CREATE INDEX uar_idx ON labpvl.labpvl_user_asset_reaction USING btree (asset_id, asset_type_id, user_id, parent_comment_id NULLS FIRST);


--
