-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: ix_stn_assets_view_viewdate
-- Type: INDEX

-- Name: ix_stn_assets_view_viewdate; Type: INDEX; Schema: stn; Owner: -
--

CREATE INDEX ix_stn_assets_view_viewdate ON stn.stn_assets_view USING btree (view_date DESC NULLS LAST);


--
