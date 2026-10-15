-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdms
-- Object: uar_aatr_idx_4
-- Type: INDEX

-- Name: uar_aatr_idx_4; Type: INDEX; Schema: labdms; Owner: -
--

CREATE INDEX uar_aatr_idx_4 ON labdms.labdms_asset_comment_reaction_dk USING btree (comment_id, reaction_date DESC NULLS LAST);


--
