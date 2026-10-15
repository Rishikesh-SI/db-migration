-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: u17wc
-- Object: ix_scup_site_partner_sid
-- Type: INDEX

-- Name: ix_scup_site_partner_sid; Type: INDEX; Schema: u17wc; Owner: -
--

CREATE INDEX ix_scup_site_partner_sid ON u17wc.u17wc_site_partner USING btree (site_id);


--
