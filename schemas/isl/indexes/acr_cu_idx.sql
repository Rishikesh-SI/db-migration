-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: acr_cu_idx
-- Type: INDEX

-- Name: acr_cu_idx; Type: INDEX; Schema: isl; Owner: -
--

CREATE INDEX acr_cu_idx ON isl.isl_asset_comment_reaction USING btree (comment_id, user_id);


--
