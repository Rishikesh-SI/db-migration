-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: ix_abp_assets_view_viewdate
-- Type: INDEX

-- Name: ix_abp_assets_view_viewdate; Type: INDEX; Schema: abpp; Owner: -
--

CREATE INDEX ix_abp_assets_view_viewdate ON abpp.abp_assets_view USING btree (view_date DESC NULLS LAST);


--
