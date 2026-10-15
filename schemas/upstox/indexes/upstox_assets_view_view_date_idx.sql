-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upstox
-- Object: upstox_assets_view_view_date_idx
-- Type: INDEX

-- Name: upstox_assets_view_view_date_idx; Type: INDEX; Schema: upstox; Owner: -
--

CREATE INDEX upstox_assets_view_view_date_idx ON upstox.upstox_assets_view USING btree (view_date DESC NULLS LAST);


--
