-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labw88
-- Object: ix_ttmum_assets_view_viewdate
-- Type: INDEX

-- Name: ix_ttmum_assets_view_viewdate; Type: INDEX; Schema: labw88; Owner: -
--

CREATE INDEX ix_ttmum_assets_view_viewdate ON labw88.labw88_assets_view USING btree (view_date DESC NULLS LAST);


--
