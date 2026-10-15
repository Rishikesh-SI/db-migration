-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: acr_cu_idx
-- Type: INDEX

-- Name: acr_cu_idx; Type: INDEX; Schema: labmi; Owner: -
--

CREATE INDEX acr_cu_idx ON labmi.labmi_asset_comment_reaction USING btree (comment_id, user_id);


--
