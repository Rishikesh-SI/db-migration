-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdms
-- Object: uar_aatr_idx_3
-- Type: INDEX

-- Name: uar_aatr_idx_3; Type: INDEX; Schema: labdms; Owner: -
--

CREATE INDEX uar_aatr_idx_3 ON labdms.labdms_user_asset_reaction_dk USING btree (parent_comment_id DESC NULLS LAST);


--
