-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: fanxp_lsg
-- Object: lablsg_assets_view_view_date_idx
-- Type: INDEX

-- Name: lablsg_assets_view_view_date_idx; Type: INDEX; Schema: fanxp_lsg; Owner: -
--

CREATE INDEX lablsg_assets_view_view_date_idx ON fanxp_lsg.lablsg_assets_view USING btree (view_date DESC NULLS LAST);


--
