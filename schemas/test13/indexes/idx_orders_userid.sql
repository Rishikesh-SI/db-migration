-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: test13
-- Object: idx_orders_userid
-- Type: INDEX

-- Name: idx_orders_userid; Type: INDEX; Schema: test13; Owner: -
--

CREATE INDEX idx_orders_userid ON test13.orders USING btree (user_id);


--
