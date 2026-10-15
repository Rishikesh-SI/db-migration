-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstlz
-- Object: ix_kxp_assets_view_viewdate
-- Type: INDEX

-- Name: ix_kxp_assets_view_viewdate; Type: INDEX; Schema: labstlz; Owner: -
--

CREATE INDEX ix_kxp_assets_view_viewdate ON labstlz.labstlz_assets_view USING btree (view_date DESC NULLS LAST);


--
