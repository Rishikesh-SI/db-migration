-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpc
-- Object: ix_ttmum_site_partner_pgid
-- Type: INDEX

-- Name: ix_ttmum_site_partner_pgid; Type: INDEX; Schema: labpc; Owner: -
--

CREATE INDEX ix_ttmum_site_partner_pgid ON labpc.labpc_page_partner USING btree (page_id);


--
