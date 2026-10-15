-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxp1
-- Object: ix_kxp_assets_view_viewdate
-- Type: INDEX

-- Name: ix_kxp_assets_view_viewdate; Type: INDEX; Schema: labkxp1; Owner: -
--

CREATE INDEX ix_kxp_assets_view_viewdate ON labkxp1.labkxp_assets_view USING btree (view_date DESC NULLS LAST);


--
