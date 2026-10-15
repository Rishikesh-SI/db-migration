-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrs_2602
-- Object: ix_ttmum_assets_view_viewdate
-- Type: INDEX

-- Name: ix_ttmum_assets_view_viewdate; Type: INDEX; Schema: labrs_2602; Owner: -
--

CREATE INDEX ix_ttmum_assets_view_viewdate ON labrs_2602.labrs_assets_view USING btree (view_date DESC NULLS LAST);


--
