-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labw88
-- Object: uar_idx
-- Type: INDEX

-- Name: uar_idx; Type: INDEX; Schema: labw88; Owner: -
--

CREATE INDEX uar_idx ON labw88.labw88_user_asset_reaction USING btree (asset_id, asset_type_id, user_id, parent_comment_id NULLS FIRST);


--
