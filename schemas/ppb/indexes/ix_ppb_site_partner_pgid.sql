-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ppb
-- Object: ix_ppb_site_partner_pgid
-- Type: INDEX

-- Name: ix_ppb_site_partner_pgid; Type: INDEX; Schema: ppb; Owner: -
--

CREATE INDEX ix_ppb_site_partner_pgid ON ppb.ppb_page_partner USING btree (page_id);


--
