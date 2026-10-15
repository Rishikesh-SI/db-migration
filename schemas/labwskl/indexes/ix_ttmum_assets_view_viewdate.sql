-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwskl
-- Object: ix_ttmum_assets_view_viewdate
-- Type: INDEX

-- Name: ix_ttmum_assets_view_viewdate; Type: INDEX; Schema: labwskl; Owner: -
--

CREATE INDEX ix_ttmum_assets_view_viewdate ON labwskl.labwskl_assets_view USING btree (view_date DESC NULLS LAST);


--
