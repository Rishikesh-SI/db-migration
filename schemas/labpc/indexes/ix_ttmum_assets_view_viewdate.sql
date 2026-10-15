-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpc
-- Object: ix_ttmum_assets_view_viewdate
-- Type: INDEX

-- Name: ix_ttmum_assets_view_viewdate; Type: INDEX; Schema: labpc; Owner: -
--

CREATE INDEX ix_ttmum_assets_view_viewdate ON labpc.labpc_assets_view USING btree (view_date DESC NULLS LAST);


--
