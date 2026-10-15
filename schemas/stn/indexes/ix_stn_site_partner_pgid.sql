-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: ix_stn_site_partner_pgid
-- Type: INDEX

-- Name: ix_stn_site_partner_pgid; Type: INDEX; Schema: stn; Owner: -
--

CREATE INDEX ix_stn_site_partner_pgid ON stn.stn_page_partner USING btree (page_id);


--
