-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: uar_raaurp_idx
-- Type: INDEX

-- Name: uar_raaurp_idx; Type: INDEX; Schema: isl; Owner: -
--

CREATE INDEX uar_raaurp_idx ON isl.isl_user_asset_reaction USING btree (reaction_date DESC, asset_id, asset_type_id, user_id, reaction_id, parent_comment_id);


--
