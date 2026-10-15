-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1_02042024
-- Object: ix_ttmum_assets_view_viewdate
-- Type: INDEX

-- Name: ix_ttmum_assets_view_viewdate; Type: INDEX; Schema: labkc_v1_02042024; Owner: -
--

CREATE INDEX ix_ttmum_assets_view_viewdate ON labkc_v1_02042024.labkc_v1_assets_view USING btree (view_date DESC NULLS LAST);


--
