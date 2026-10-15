-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdms
-- Object: uar_aatr_idx_1
-- Type: INDEX

-- Name: uar_aatr_idx_1; Type: INDEX; Schema: labdms; Owner: -
--

CREATE INDEX uar_aatr_idx_1 ON labdms.labdms_user_asset_reaction_dk USING btree (asset_id DESC NULLS LAST, asset_type_id DESC NULLS LAST, reaction_id DESC NULLS LAST);


--
