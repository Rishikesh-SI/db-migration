-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: u17wc
-- Object: ix_scup_site_partner_pgid
-- Type: INDEX

-- Name: ix_scup_site_partner_pgid; Type: INDEX; Schema: u17wc; Owner: -
--

CREATE INDEX ix_scup_site_partner_pgid ON u17wc.u17wc_page_partner USING btree (page_id);


--
