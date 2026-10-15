-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1
-- Object: acr_cu_idx
-- Type: INDEX

-- Name: acr_cu_idx; Type: INDEX; Schema: labmi_v1; Owner: -
--

CREATE INDEX acr_cu_idx ON labmi_v1.labmi_v1_asset_comment_reaction USING btree (comment_id, user_id);


--
