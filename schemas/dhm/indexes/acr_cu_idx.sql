-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: acr_cu_idx
-- Type: INDEX

-- Name: acr_cu_idx; Type: INDEX; Schema: dhm; Owner: -
--

CREATE INDEX acr_cu_idx ON dhm.dhm_asset_comment_reaction USING btree (comment_id, user_id);


--
