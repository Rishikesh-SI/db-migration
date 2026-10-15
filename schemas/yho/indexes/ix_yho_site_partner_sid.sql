-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: ix_yho_site_partner_sid
-- Type: INDEX

-- Name: ix_yho_site_partner_sid; Type: INDEX; Schema: yho; Owner: -
--

CREATE INDEX ix_yho_site_partner_sid ON yho.yho_site_partner USING btree (site_id);


--
