-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labal_nassr
-- Object: ix_ttmum_assets_view_viewdate
-- Type: INDEX

-- Name: ix_ttmum_assets_view_viewdate; Type: INDEX; Schema: labal_nassr; Owner: -
--

CREATE INDEX ix_ttmum_assets_view_viewdate ON labal_nassr.labal_nassr_assets_view USING btree (view_date DESC NULLS LAST);


--
