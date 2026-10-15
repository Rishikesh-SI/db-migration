-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labso_bkp
-- Object: ix_ttmum_assets_view_viewdate
-- Type: INDEX

-- Name: ix_ttmum_assets_view_viewdate; Type: INDEX; Schema: labso_bkp; Owner: -
--

CREATE INDEX ix_ttmum_assets_view_viewdate ON labso_bkp.labso_assets_view USING btree (view_date DESC NULLS LAST);


--
