-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labjdtest
-- Object: ix_ttmum_assets_view_viewdate
-- Type: INDEX

-- Name: ix_ttmum_assets_view_viewdate; Type: INDEX; Schema: labjdtest; Owner: -
--

CREATE INDEX ix_ttmum_assets_view_viewdate ON labjdtest.labjdtest_assets_view USING btree (view_date DESC NULLS LAST);


--
