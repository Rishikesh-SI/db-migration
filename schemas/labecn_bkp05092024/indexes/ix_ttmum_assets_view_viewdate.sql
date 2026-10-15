-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labecn_bkp05092024
-- Object: ix_ttmum_assets_view_viewdate
-- Type: INDEX

-- Name: ix_ttmum_assets_view_viewdate; Type: INDEX; Schema: labecn_bkp05092024; Owner: -
--

CREATE INDEX ix_ttmum_assets_view_viewdate ON labecn_bkp05092024.labecn_assets_view USING btree (view_date DESC NULLS LAST);


--
